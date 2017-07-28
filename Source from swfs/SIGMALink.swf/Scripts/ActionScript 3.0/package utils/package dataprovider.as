//package dataprovider
//  class CommonAlarmModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAlarmModeDataProvider extends Object
    {
        public function CommonAlarmModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_OFF"), "data":"off"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_DAILY"), "data":"everyDay"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_WORK_DAYS"), "data":"workDay"}, {"label":utils.LanguageManager.getString("SETTINGS_ALARM_MODE_ONCE"), "data":"oneTime"}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonAltitudeReferenceDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonAltitudeReferenceDataProvider extends Object
    {
        public function CommonAltitudeReferenceDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_ACTUAL_ALTITUDE"), "data":core.general.AltitudeReference.ACTUAL_ALTITUDE}, {"label":utils.LanguageManager.getString("SETTINGS_AIR_PRESSURE"), "data":core.general.AltitudeReference.SEA_LEVEL}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonAltitudeUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAltitudeUnitDataProvider extends Object
    {
        public function CommonAltitudeUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_METER"), "data":"meter"}, {"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_FEET"), "data":"feet"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_METER"), "data":"meter"}, {"label":utils.LanguageManager.getString("ALTITUDE_FORMAT_FEET"), "data":"feet"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonAutoLapDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonAutoLapDataProvider extends Object
    {
        public function CommonAutoLapDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_OFF"), "data":0}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_DISTANCE"), "data":1}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_TIME"), "data":2}, {"label":utils.LanguageManager.getString("SETTINGS_AUTOLAP_BASEDON_CALORIES"), "data":3}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonAutoOffTimeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonAutoOffTimeDataProvider extends Object
    {
        public function CommonAutoOffTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_OFF"), "data":core.general.AutoOffTimeUnit.OFF}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_5MIN"), "data":core.general.AutoOffTimeUnit.FIVE_MINUTES}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_30MIN"), "data":core.general.AutoOffTimeUnit.THIRTY_MINUTES}, {"label":utils.LanguageManager.getString("SETTINGS_AUTO_OFF_TIME_1HOUR"), "data":core.general.AutoOffTimeUnit.ONE_HOURS}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonBacklightTimeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonBacklightTimeDataProvider extends Object
    {
        public function CommonBacklightTimeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("BACKLIGHT_TIME_PERMANENT"), "data":0}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_5_MIN_ON"), "data":1}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_2_MIN_ON"), "data":2}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_30_SEC_ON"), "data":3}]);
            DATA_PROVIDER_ROX70_ROX110 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("BACKLIGHT_TIME_PERMANENT"), "data":3}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_5_MIN_ON"), "data":2}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_2_MIN_ON"), "data":1}, {"label":utils.LanguageManager.getString("BACKLIGHT_TIME_30_SEC_ON"), "data":0}]);
            return;
        }

        public static var DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;

        public static var DATA_PROVIDER_ROX70_ROX110:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonBikeTypeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonBikeTypeDataProvider extends Object
    {
        public function CommonBikeTypeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_RACE_DROP"), "data":"raceDrop"}, {"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_RACE_HOODS"), "data":"raceHoods"}, {"label":utils.LanguageManager.getString("SETTINGS_BIKE_TYPE_MOUNTAIN_BIKE"), "data":"mountainBike"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonClockFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonClockFormatDataProvider extends Object
    {
        public function CommonClockFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("CLOCK_FORMAT_24"), "data":"24"}, {"label":utils.LanguageManager.getString("CLOCK_FORMAT_12"), "data":"12"}]);
            V_AM_PM_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_AM"), "data":"AM"}, {"label":utils.LanguageManager.getString("UNIT_PM"), "data":"PM"}]);
            return;
        }

        public static var V_AM_PM_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonDateFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonDateFormatDataProvider extends Object
    {
        public function CommonDateFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DATEFORMAT_EU"), "data":"eu"}, {"label":utils.LanguageManager.getString("SETTINGS_DATEFORMAT_US"), "data":"us"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonDistanceUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonDistanceUnitDataProvider extends Object
    {
        public function CommonDistanceUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("DISTANCE_FORMAT_KILOMETER"), "data":"kilometer"}, {"label":utils.LanguageManager.getString("DISTANCE_FORMAT_MILE"), "data":"mile"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("DISTANCE_FORMAT_KILOMETER"), "data":"kilometer"}, {"label":utils.LanguageManager.getString("DISTANCE_FORMAT_MILE"), "data":"mile"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonETAModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonETAModeDataProvider extends Object
    {
        public function CommonETAModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DETAIL_BICYCLE_ETA_MODE_TIME"), "data":false}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_BICYCLE_ETA_MODE_CLOCK"), "data":true}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonFavoritesPC2812DataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonFavoritesPC2812DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function CommonFavoritesPC2812DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_TRIP = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "data":1, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "data":2, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "data":3, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PROFILE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PROFILE"), "data":4, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_INTENSITY_ZONES_PC2812"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_INTENSITY_ZONES_PC2812"), "data":5, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "data":6, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "data":7, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":8, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "data":9, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_OFF"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_OFF"), "data":0, "image":"FavoriteNotDisplayIcon"}]);
            return;
        }

        public static var V_DATA_PROVIDER_TRIP:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonFavoritesRox100DataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonFavoritesRox100DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function CommonFavoritesRox100DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_TRIP = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_OFF"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":0, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":1, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":2, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":3, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":4, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":5, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":6, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":7, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":8, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":9, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":10, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":11, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":12, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":13, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":14, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":15, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TARGET_ZONE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":16, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_INTENSITY_ZONES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":17, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_GRAPH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":18, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_EXERCISE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":19, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":20, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":21, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":22, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":23, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":24, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_3S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":25, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_30S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":26, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":27, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":28, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_WORK_IN_KJ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":29, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_W_PER_KG"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":30, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_TARGETZ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":31, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_7_ZONE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":32, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":33, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":34, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":35, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":36, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":37, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":38, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_PROFILE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":39, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":40, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":41, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":42, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":43, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":44, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":45, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":46, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":47, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":48, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":49, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":50, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":51, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":52, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":53, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":54, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":55, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":56, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_BATTERY_STATUS"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":57, "image":"FavoriteBatteryStatusIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_ACCURACY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":58, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_SIGNAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":59, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":60, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_OF_ARRIVAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":61, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIST_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":62, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIRECTION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":63, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_MINI_TRACK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":64, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_NUMBER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":65, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":66, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":67, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":68, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":69, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":70, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":71, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":72, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":73, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":74, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":75, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":76, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":77, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":78, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_ASC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":79, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_DESC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":80, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_UPHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":81, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_DOWNHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":82, "image":"FavoriteLapIcon"}]);
            V_DATA_PROVIDER_TRACK_ALTI = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_OFF"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":0, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_FULL_SCREEN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":75, "image":"FavoriteNotDisplayIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":1, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":2, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":3, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":4, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":5, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":6, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":7, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":8, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":9, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":10, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":11, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":12, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":13, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":14, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":15, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_EXERCISE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":16, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":17, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":18, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":19, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":20, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":21, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_3S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":22, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_30S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":23, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":24, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":25, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_WORK_IN_KJ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":26, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_W_PER_KG"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":27, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":28, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":29, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":30, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":31, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":32, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":33, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":34, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":35, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":36, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":37, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":38, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":39, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":40, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":41, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":42, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":43, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":44, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":45, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":46, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":47, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":48, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":49, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":50, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_BATTERY_STATUS"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":51, "image":"FavoriteBatteryStatusIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_ACCURACY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":52, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":53, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_OF_ARRIVAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":54, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIST_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":55, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIRECTION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":56, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_NUMBER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":57, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":58, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":59, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":60, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":61, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":62, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":63, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":64, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":65, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":66, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":67, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":68, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":69, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":70, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_ASC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":71, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_DESC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":72, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_UPHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":73, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_DOWNHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":74, "image":"FavoriteLapIcon"}]);
            V_DATA_PROVIDER_LAP = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_OFF"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":0, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_NUMBER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":1, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":2, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME_SINCE_START"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":3, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":4, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE_SINCE_START"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":5, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":6, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":7, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":8, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":9, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":10, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":11, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":12, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":13, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":14, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":15, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":16, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_ASC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":17, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_DESC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":18, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_UPHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":19, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_DOWNHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":20, "image":"FavoriteLapIcon"}]);
            V_DATA_PROVIDER_PAGE_COUNT = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_OFF"), "data":0}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_1"), "data":1}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_2"), "data":2}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_3"), "data":3}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_4"), "data":4}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_5"), "data":5}, {"label":utils.LanguageManager.getString("SETTINGS_CUSTOM_6"), "data":6}]);
            V_DATA_PROVIDER_CUSTOM = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":1, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":2, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":3, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":4, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":5, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":6, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":7, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":8, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":9, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":10, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":11, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM_HEARTRATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":12, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":13, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE_PERCENT_HR_MAX"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":14, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":15, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TARGET_ZONE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":16, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_INTENSITY_ZONES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":17, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_GRAPH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "data":18, "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_EXERCISE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":19, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":20, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":21, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":22, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "data":23, "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":24, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_3S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":25, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_AVG_30S"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":26, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":27, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":28, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_WORK_IN_KJ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":29, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_W_PER_KG"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":30, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_TARGETZ"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":31, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER_7_ZONE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "data":32, "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":33, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":34, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "data":35, "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":36, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":37, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":38, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE_PROFILE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_ALTITUDE"), "data":39, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":40, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":41, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":42, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":43, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":44, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":45, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":46, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":47, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "data":48, "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":49, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":50, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":51, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":52, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":53, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":54, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":55, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "data":56, "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_BATTERY_STATUS"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":57, "image":"FavoriteBatteryStatusIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_ACCURACY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":58, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_GPS_SIGNAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_STATUS"), "data":59, "image":"FavoriteGPSIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":60, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_TIME_OF_ARRIVAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":61, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIST_TO_DESTINATION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":62, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_DIRECTION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":63, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION_MINI_TRACK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_NAVIGATION"), "data":64, "image":"FavoriteNavigationIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_NUMBER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":65, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":66, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":67, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":68, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_SPEED"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":69, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":70, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_HR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":71, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":72, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":73, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":74, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":75, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":76, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":77, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_MAX_ALTI"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":78, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_ASC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":79, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_ALTI_DESC"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":80, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_UPHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":81, "image":"FavoriteLapIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP_AVG_INCLINE_DOWNHILL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_LAP"), "data":82, "image":"FavoriteLapIcon"}]);
            return;
        }

        public static var V_DATA_PROVIDER_CUSTOM:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_LAP:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_PAGE_COUNT:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_TRACK_ALTI:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_TRIP:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonFavoritesRox2010DataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonFavoritesRox2010DataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function CommonFavoritesRox2010DataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[0], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_RIDE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[1], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[2], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[3], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE_UP_DOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[4], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[6], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[7], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_GHOST_RACE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[8], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[47], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[48], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[49], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[50], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[51], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[10], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[11], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[12], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_1"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[13], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_2"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[14], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_3"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[15], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[16], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_ACTUAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[18], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[19], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[20], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[22], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[23], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[24], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[25], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[26], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[27], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[28], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[29], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[30], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[52], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[32], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[33], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[34], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[35], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[36], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[37], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[38], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[39], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[41], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[42], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[43], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[44], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_ALARM_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[45], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[53], "image":"FavoriteNotDisplayIcon"}]);
            V_DATA_PROVIDER_ROX8_1 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[0], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_RIDE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[1], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[2], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[3], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE_UP_DOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[4], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[6], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[7], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[47], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[48], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[49], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[50], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_POWER"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[51], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[10], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[11], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[12], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_1"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[13], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_2"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[14], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_3"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[15], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[16], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_ACTUAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[18], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[19], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[20], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[22], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[23], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[24], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[25], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[26], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[27], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[28], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[29], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[30], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_EXPANSION"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[52], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[32], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[33], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[34], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[35], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[36], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[37], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[38], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[39], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[41], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[42], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[43], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[44], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_ALARM_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[45], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "bgColor":"", "data":core.general.FavoritesROX2010.FAVORITES_GUI[53], "image":"FavoriteNotDisplayIcon"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX8_1:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonFavoritesRoxDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonFavoritesRoxDataProvider extends utils.dataprovider.GraphicsnameConstants
    {
        public function CommonFavoritesRoxDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[0], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_RIDE_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[1], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[2], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[3], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE_UP"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[4], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_DISTANCE_DOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[5], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_AVERAGE_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[6], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING_MAXIMUM_CADENCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_CYCLING"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[7], "image":"FavoriteCyclingIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_ZONEBAR"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[8], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[9], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[10], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_1"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[11], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_2"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[12], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_TIME_ZONE_3"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[13], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE_CALORIES"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_HEARTRATE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[14], "image":"FavoriteHeartrateIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_ACTUAL"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[15], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MINIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[16], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE_MAXIMUM"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TEMPERATURE"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[17], "image":"FavoriteTemperatureIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_CLIMB"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[18], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_ALTITUDE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[19], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[20], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[21], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[22], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[23], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[24], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[25], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_UPHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[26], "image":"FavoriteUphillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DESCEND"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[27], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_DISTANCE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[28], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_TRIP_TIME"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[29], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[30], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[31], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_RISE_RATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[32], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_MAXIMUM_INCLINE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[33], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL_AVERAGE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DOWNHILL"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[34], "image":"FavoriteDownhillIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[35], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_DATE"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[36], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_STOPWATCH"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[37], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_COUNTDOWN"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[38], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME_ALARM_CLOCK"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_TIME"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[39], "image":"FavoriteTimeIcon"}, {"label":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "category":utils.LanguageManager.getString("SETTINGS_FAVORITES_DO_NOT_DISPLAY"), "bgColor":"", "data":core.general.Favorites.FAVORITES_GUI[40], "image":"FavoriteNotDisplayIcon"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonFuelConsumptionDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonFuelConsumptionDataProvider extends Object
    {
        public function CommonFuelConsumptionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_LITER"), "data":"l/100km"}, {"label":utils.LanguageManager.getString("UNIT_GALLON"), "data":"mpg"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonGPSFormatDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonGPSFormatDataProvider extends Object
    {
        public function CommonGPSFormatDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":"hddd°mm,mmm", "data":"hddd°mm,mmm"}, {"label":"hddd°mm\'ss,s", "data":"hddd°mm\'ss,s"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonGenderDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonGenderDataProvider extends Object
    {
        public function CommonGenderDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_MALE"), "data":"male"}, {"label":utils.LanguageManager.getString("SETTINGS_FEMALE"), "data":"female"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonHeightUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonHeightUnitDataProvider extends Object
    {
        public function CommonHeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CM"), "data":"centimeter"}, {"label":utils.LanguageManager.getString("SETTINGS_INCH"), "data":"inch"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonLanguageDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonLanguageDataProvider extends Object
    {
        public function CommonLanguageDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BETA_TEST = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de_DE"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en_US"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es_ES"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr_FR"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it_IT"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl_NL"}]);
            V_DATA_PROVIDER_GPS10 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl"}, {"label":utils.LanguageManager.getString("LANGUAGE_POLISH"), "data":"pl"}]);
            V_DATA_PROVIDER_PC2814 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}]);
            V_DATA_PROVIDER_RC2011 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}]);
            V_DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}]);
            V_DATA_PROVIDER_ROX2008 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}]);
            V_DATA_PROVIDER_ROX2010 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}]);
            V_DATA_PROVIDER_ROX70_ROX110 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl"}, {"label":utils.LanguageManager.getString("LANGUAGE_POLISH"), "data":"pl"}, {"label":utils.LanguageManager.getString("LANGUAGE_CZECH"), "data":"cs"}]);
            V_DATA_PROVIDER_SOFTWARESETTINGS_EN = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de_DE"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en_US"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es_ES"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr_FR"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it_IT"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl_NL"}, {"label":utils.LanguageManager.getString("LANGUAGE_POLISH"), "data":"pl_PL"}, {"label":utils.LanguageManager.getString("LANGUAGE_CZECH"), "data":"cs_CZ"}]);
            V_DATA_PROVIDER_SOFTWARESETTINGS_JA_CH = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de_DE"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en_US"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es_ES"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr_FR"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it_IT"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl_NL"}]);
            V_DATA_PROVIDER_TOPLINE2009 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_SWEDISH"), "data":"se"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl"}]);
            V_DATA_PROVIDER_TOPLINE2012 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("LANGUAGE_GERMAN"), "data":"de"}, {"label":utils.LanguageManager.getString("LANGUAGE_ENGLISH"), "data":"en"}, {"label":utils.LanguageManager.getString("LANGUAGE_FRENCH"), "data":"fr"}, {"label":utils.LanguageManager.getString("LANGUAGE_ITALIAN"), "data":"it"}, {"label":utils.LanguageManager.getString("LANGUAGE_SPANISH"), "data":"es"}, {"label":utils.LanguageManager.getString("LANGUAGE_DUTCH"), "data":"nl"}, {"label":utils.LanguageManager.getString("LANGUAGE_POLISH"), "data":"pl"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BETA_TEST:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_GPS10:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_PC2814:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RC2011:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX2008:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX2010:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX70_ROX110:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARESETTINGS_EN:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARESETTINGS_JA_CH:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_TOPLINE2009:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_TOPLINE2012:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonMeasurementDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonMeasurementDataProvider extends Object
    {
        public function CommonMeasurementDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_KMH"), "data":"kmh"}, {"label":utils.LanguageManager.getString("SETTINGS_MPH"), "data":"mph"}]);
            V_DATA_PROVIDER_RC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_KMH"), "data":"kmh"}, {"label":utils.LanguageManager.getString("SETTINGS_MPH"), "data":"mph"}, {"label":utils.LanguageManager.getString("SETTINGS_MIN_KM"), "data":"min/km"}, {"label":utils.LanguageManager.getString("SETTINGS_MIN_MI"), "data":"min/mi"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RC:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonRouteOptionsDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonRouteOptionsDataProvider extends Object
    {
        public function CommonRouteOptionsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_SUITABLE_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ROUTE_SUITABLE_HIKING"), "param":"trekking", "sportId":"6", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_WALKING"), "param":"walking", "sportId":"5", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_RUNNING"), "param":"jogging", "sportId":"4", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_BICYCLETOUR"), "param":"biking", "sportId":"3", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_MOUNTAINBIKE"), "param":"mountainbiking", "sportId":"2", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_RACINGBICYCLE"), "param":"racingbike", "sportId":"1", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_INLINESKATING"), "param":"skating", "sportId":"12", "selectable":true}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_CROSSSKATING"), "param":"crossskating", "sportId":"12", "selectable":false}, {"label":utils.LanguageManager.getString("ROUTE_SUITABLE_HANDBIKE"), "param":"handcycle", "sportId":"15", "selectable":true}]);
            V_CHARACTERISTIC_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_FLAT"), "param":"flat"}, {"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_HILLY"), "param":"hilly"}, {"label":utils.LanguageManager.getString("ROUTE_CHARACTERISTICS_MOUNTAINOUS"), "param":"mountainous"}]);
            V_TYPE_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ALL"), "data":0}, {"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ROUND_TRIP"), "data":1}, {"label":utils.LanguageManager.getString("GPSIES_TRACK_PROPERTY_ONE_WAY_TRIP"), "data":2}]);
            return;
        }

        public static function resolveSportId(arg1:String):uint
        {
            var loc3:*=0;
            var loc2:*=V_SUITABLE_DATA_PROVIDER.length;
            var loc1:*=0;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (V_SUITABLE_DATA_PROVIDER[loc3].param == arg1) 
                {
                    loc1 = V_SUITABLE_DATA_PROVIDER[loc3].sportId;
                    break;
                }
                ++loc3;
            }
            return loc1;
        }

        public static function resolveSportParams():Array
        {
            return getParams(V_SUITABLE_DATA_PROVIDER);
        }

        public static function resolveSportParam(arg1:int):String
        {
            var loc2:*=0;
            var loc1:*=V_SUITABLE_DATA_PROVIDER.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (V_SUITABLE_DATA_PROVIDER[loc2].sportId == arg1) 
                {
                    return V_SUITABLE_DATA_PROVIDER[loc2].param;
                }
                ++loc2;
            }
            return "biking";
        }

        public static function resolveCategoryParams():Array
        {
            return getParams(V_CHARACTERISTIC_DATA_PROVIDER);
        }

        internal static function getParams(arg1:__AS3__.vec.Vector.<Object>):Array
        {
            var loc3:*=0;
            var loc2:*=undefined;
            loc2 = arg1;
            var loc1:*=loc2.length;
            var loc4:*=[];
            loc3 = 0;
            while (loc3 < loc1) 
            {
                loc4[loc4.length] = "\'" + loc2[loc3].param + "\'";
                ++loc3;
            }
            return loc4;
        }

        public static var V_CHARACTERISTIC_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_SUITABLE_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var V_TYPE_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonSamplingRateDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonSamplingRateDataProvider extends Object
    {
        public function CommonSamplingRateDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_PC2814 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_RC1411 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":"1 s", "data":1}, {"label":"2 s", "data":2}, {"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}, {"label":"30 s", "data":30}]);
            V_DATA_PROVIDER_BC2316 = __AS3__.vec.Vector.<Object>([{"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}]);
            V_DATA_PROVIDER_ROX110 = __AS3__.vec.Vector.<Object>([{"label":"1 s", "data":1}, {"label":"2 s", "data":2}, {"label":"5 s", "data":5}, {"label":"10 s", "data":10}, {"label":"20 s", "data":20}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC2316:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_PC2814:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RC1411:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX110:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonTemperatureUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTemperatureUnitDataProvider extends Object
    {
        public function CommonTemperatureUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_BC = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CELSIUS"), "data":"celsius"}, {"label":utils.LanguageManager.getString("SETTINGS_FAHRENHEIT"), "data":"fahrenheit"}]);
            V_DATA_PROVIDER_SOFTWARE_SETTINGS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_CELSIUS"), "data":"celsius"}, {"label":utils.LanguageManager.getString("SETTINGS_FAHRENHEIT"), "data":"fahrenheit"}]);
            return;
        }

        public static var V_DATA_PROVIDER_BC:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_SOFTWARE_SETTINGS:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonTimeZoneDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    
    public class CommonTimeZoneDataProvider extends Object
    {
        public function CommonTimeZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"data":0, "label":"Almaty (GMT+06:00)"}, {"data":1, "label":"Athens (GMT+02:00)"}, {"data":2, "label":"Auckland (GMT+12:00)"}, {"data":3, "label":"Azores (GMT-01:00)"}, {"data":4, "label":"Baghdad (GMT+03:00)"}, {"data":5, "label":"Baku (GMT+04:00)"}, {"data":6, "label":"Bangkok (GMT+07:00)"}, {"data":7, "label":"Beijing (GMT+08:00)"}, {"data":8, "label":"Berlin (GMT+01:00)"}, {"data":9, "label":"Bern (GMT+01:00)"}, {"data":10, "label":"Brasilia (GMT-03:00)"}, {"data":11, "label":"Brussels (GMT+01:00)"}, {"data":12, "label":"Budapest (GMT+01:00)"}, {"data":13, "label":"BuenosAires (GMT-03:00)"}, {"data":14, "label":"Cairo (GMT+02:00)"}, {"data":15, "label":"Canberra (GMT+10:00)"}, {"data":16, "label":"CapeVerdeIs. (GMT-01:00)"}, {"data":17, "label":"Caracas (GMT-04:00)"}, {"data":18, "label":"Chennai (GMT+05:30)"}, {"data":19, "label":"Copenhageu (GMT+01:00)"}, {"data":20, "label":"Darwin (GMT+09:30)"}, {"data":21, "label":"Dublin (GMT+00:00)"}, {"data":22, "label":"Edinburgh (GMT+00:00)"}, {"data":23, "label":"Fiji (GMT+12:00)"}, {"data":24, "label":"Georgetown (GMT-03:00)"}, {"data":25, "label":"Greenland (GMT-03:00)"}, {"data":26, "label":"Guam (GMT+10:00)"}, {"data":27, "label":"Hanoi (GMT+07:00)"}, {"data":28, "label":"HongKong (GMT+08:00)"}, {"data":29, "label":"Islamabad (GMT+05:00)"}, {"data":30, "label":"Istanbul (GMT+02:00)"}, {"data":31, "label":"Jakarta (GMT+07:00)"}, {"data":32, "label":"Jerusalem (GMT+02:00)"}, {"data":33, "label":"Kabul (GMT+04:30)"}, {"data":34, "label":"Karachi (GMT+05:00)"}, {"data":35, "label":"Kuwaut (GMT+03:00)"}, {"data":36, "label":"Lima (GMT-05:00)"}, {"data":37, "label":"Lisbon (GMT+00:00)"}, {"data":38, "label":"London (GMT+00:00)"}, {"data":39, "label":"Madrid (GMT+01:00)"}, {"data":40, "label":"Magadan (GMT+11:00)"}, {"data":41, "label":"Melbourne (GMT+10:00)"}, {"data":42, "label":"Mexico (GMT-06:00)"}, {"data":43, "label":"Mid-Atlantic (GMT-02:00)"}, {"data":44, "label":"Monrovia (GMT+00:00)"}, {"data":45, "label":"Moscow (GMT+03:00)"}, {"data":46, "label":"Mumbai (GMT+05:30)"}, {"data":47, "label":"Muscat (GMT+04:00)"}, {"data":48, "label":"Newfoundland (GMT-03:30)"}, {"data":49, "label":"Paris (GMT+01:00)"}, {"data":50, "label":"Prague (GMT+01:00)"}, {"data":51, "label":"Quito (GMT-05:00)"}, {"data":52, "label":"Rome (GMT+01:00)"}, {"data":53, "label":"Samoa (GMT-11:00)"}, {"data":54, "label":"Santiago (GMT-04:00)"}, {"data":55, "label":"Seoul (GMT+09:00)"}, {"data":56, "label":"Singapore (GMT+08:00)"}, {"data":57, "label":"SolomonIs. (GMT+11:00)"}, {"data":58, "label":"Sydney (GMT+10:00)"}, {"data":59, "label":"Taipei (GMT+08:00)"}, {"data":60, "label":"Tashkent (GMT+05:00)"}, {"data":61, "label":"Tehran (GMT+03:30)"}, {"data":62, "label":"Tokyo (GMT+09:00)"}, {"data":63, "label":"US-Alaska (GMT-09:00)"}, {"data":64, "label":"US-Arizona (GMT-07:00)"}, {"data":65, "label":"US-Atlantic (GMT-04:00)"}, {"data":66, "label":"US-Central (GMT-06:00)"}, {"data":67, "label":"US-Eastern (GMT-05:00)"}, {"data":68, "label":"US-Hawaii (GMT-10:00)"}, {"data":69, "label":"US-Mountain (GMT-07:00)"}, {"data":70, "label":"US-Pacific (GMT-08:00)"}, {"data":71, "label":"Vienna (GMT+01:00)"}, {"data":72, "label":"Vladivostok (GMT+10:00)"}, {"data":73, "label":"Wellington (GMT+12:00)"}, {"data":74, "label":"Yangon (GMT+06:30)"}, {"data":75, "label":"Yerevan (GMT+04:00)"}, {"data":76, "label":"-14:00"}, {"data":77, "label":"-13:30"}, {"data":78, "label":"-13:00"}, {"data":79, "label":"-12:30"}, {"data":80, "label":"-12:00"}, {"data":81, "label":"-11:30"}, {"data":82, "label":"-11:00"}, {"data":83, "label":"-10:30"}, {"data":84, "label":"-10:00"}, {"data":85, "label":"-09:30"}, {"data":86, "label":"-09:00"}, {"data":87, "label":"-08:30"}, {"data":88, "label":"-08:00"}, {"data":89, "label":"-07:30"}, {"data":90, "label":"-07:00"}, {"data":91, "label":"-06:30"}, {"data":92, "label":"-06:00"}, {"data":93, "label":"-05:30"}, {"data":94, "label":"-05:00"}, {"data":95, "label":"-04:30"}, {"data":96, "label":"-04:00"}, {"data":97, "label":"-03:30"}, {"data":98, "label":"-03:00"}, {"data":99, "label":"-02:30"}, {"data":100, "label":"-02:00"}, {"data":101, "label":"-01:30"}, {"data":102, "label":"-01:00"}, {"data":103, "label":"00:30"}, {"data":104, "label":"00:00"}, {"data":105, "label":"00:30"}, {"data":106, "label":"01:00"}, {"data":107, "label":"01:30"}, {"data":108, "label":"02:00"}, {"data":109, "label":"02:30"}, {"data":110, "label":"03:00"}, {"data":111, "label":"03:30"}, {"data":112, "label":"04:00"}, {"data":113, "label":"04:30"}, {"data":114, "label":"05:00"}, {"data":115, "label":"05:30"}, {"data":116, "label":"06:00"}, {"data":117, "label":"06:30"}, {"data":118, "label":"07:00"}, {"data":119, "label":"07:30"}, {"data":120, "label":"08:00"}, {"data":121, "label":"08:30"}, {"data":122, "label":"09:00"}, {"data":123, "label":"09:30"}, {"data":124, "label":"10:00"}, {"data":125, "label":"10:30"}, {"data":126, "label":"11:00"}, {"data":127, "label":"11:30"}, {"data":128, "label":"12:00"}, {"data":129, "label":"12:30"}, {"data":130, "label":"13:00"}, {"data":131, "label":"13:30"}, {"data":132, "label":"14:00"}]);
            DATA_PROVIDER_GPS_10 = __AS3__.vec.Vector.<Object>([{"data":0, "label":"GMT -12:00"}, {"data":1, "label":"GMT -11:00"}, {"data":2, "label":"GMT -10:00"}, {"data":3, "label":"GMT -09:30"}, {"data":4, "label":"GMT -09:00"}, {"data":5, "label":"GMT -08:00"}, {"data":6, "label":"GMT -07:00"}, {"data":7, "label":"GMT -06:00"}, {"data":8, "label":"GMT -05:00"}, {"data":9, "label":"GMT -04:30"}, {"data":10, "label":"GMT -04:00"}, {"data":11, "label":"GMT -03:30"}, {"data":12, "label":"GMT -03:00"}, {"data":13, "label":"GMT -02:00"}, {"data":14, "label":"GMT -01:00"}, {"data":15, "label":"GMT +00:00"}, {"data":16, "label":"GMT +01:00"}, {"data":17, "label":"GMT +02:00"}, {"data":18, "label":"GMT +03:00"}, {"data":19, "label":"GMT +03:30"}, {"data":20, "label":"GMT +04:00"}, {"data":21, "label":"GMT +04:30"}, {"data":22, "label":"GMT +05:00"}, {"data":23, "label":"GMT +05:30"}, {"data":24, "label":"GMT +05:45"}, {"data":25, "label":"GMT +06:00"}, {"data":26, "label":"GMT +06:30"}, {"data":27, "label":"GMT +07:00"}, {"data":28, "label":"GMT +08:00"}, {"data":29, "label":"GMT +08:45"}, {"data":30, "label":"GMT +09:00"}, {"data":31, "label":"GMT +09:30"}, {"data":32, "label":"GMT +10:00"}, {"data":33, "label":"GMT +10:30"}, {"data":34, "label":"GMT +11:00"}, {"data":35, "label":"GMT +11:30"}, {"data":36, "label":"GMT +12:00"}, {"data":37, "label":"GMT +12:45"}, {"data":38, "label":"GMT +13:00"}, {"data":39, "label":"GMT +14:00"}]);
            return;
        }

        public static var DATA_PROVIDER:__AS3__.vec.Vector.<Object>;

        public static var DATA_PROVIDER_GPS_10:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonTireModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonTireModeDataProvider extends Object
    {
        public function CommonTireModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("TIRE_SIZE_16INCH"), "data":core.general.TireSize.S_16INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_18INCH"), "data":core.general.TireSize.S_18INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_20INCH"), "data":core.general.TireSize.S_20INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_22INCH"), "data":core.general.TireSize.S_22INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_24INCH"), "data":core.general.TireSize.S_24INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_26INCH"), "data":core.general.TireSize.S_26INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_27INCH"), "data":core.general.TireSize.S_27INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_275INCH"), "data":core.general.TireSize.S_275INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_28INCH"), "data":core.general.TireSize.S_28INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_29INCH"), "data":core.general.TireSize.S_29INCH}, {"label":utils.LanguageManager.getString("TIRE_SIZE_700C"), "data":core.general.TireSize.S_700C}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonTrackDirectionDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTrackDirectionDataProvider extends Object
    {
        public function CommonTrackDirectionDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("TRACK_NORTH_DIRECTION"), "data":"north"}, {"label":utils.LanguageManager.getString("TRACK_DRIVING_DIRECTION"), "data":"drivingDirection"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonTrackDistanceDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.*;
    import utils.*;
    
    public class CommonTrackDistanceDataProvider extends Object
    {
        public function CommonTrackDistanceDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            if (core.MeasurementConfig.distanceFormat != "kilometer") 
            {
                V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_OFF_TRACK_ALARM_OFF"), "data":0}, {"label":"131 " + utils.LanguageManager.getString("UNIT_FT"), "data":1}, {"label":"262 " + utils.LanguageManager.getString("UNIT_FT"), "data":2}, {"label":"393 " + utils.LanguageManager.getString("UNIT_FT"), "data":3}]);
            }
            else 
            {
                V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_OFF_TRACK_ALARM_OFF"), "data":0}, {"label":"40 " + utils.LanguageManager.getString("UNIT_M"), "data":1}, {"label":"80 " + utils.LanguageManager.getString("UNIT_M"), "data":2}, {"label":"120 " + utils.LanguageManager.getString("UNIT_M"), "data":3}]);
            }
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonTrainingZoneDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonTrainingZoneDataProvider extends Object
    {
        public function CommonTrainingZoneDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_FIT_FAT = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}]);
            V_DATA_PROVIDER_HEARTRATE_LIMITS = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OWN_ZONE"), "data":"ownZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            V_DATA_PROVIDER_ROX100 = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_FIT_ZONE"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_FAT_ZONE"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OWN_ZONE"), "data":"ownZone"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            V_DATA_PROVIDER_RCMOVE = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_FIT"), "data":"fitZone"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_FAT"), "data":"fatZone"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_1"), "data":"ownZone1"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_2"), "data":"ownZone2"}, {"label":utils.LanguageManager.getString("SETTINGS_DETAIL_TRAINING_FREE_TARGETZONE_OWN_3"), "data":"ownZone3"}, {"label":utils.LanguageManager.getString("SETTINGS_OFF"), "data":"off"}]);
            return;
        }

        public static var V_DATA_PROVIDER_FIT_FAT:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_HEARTRATE_LIMITS:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_RCMOVE:__AS3__.vec.Vector.<Object>;

        public static var V_DATA_PROVIDER_ROX100:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonUnitsDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    
    public class CommonUnitsDataProvider extends Object
    {
        public function CommonUnitsDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER_ALL_DEVICES = new __AS3__.vec.Vector.<utils.dataprovider.UnitItemRendererData>();
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC512.getLabel(), core.general.UnitType.BC512));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC812.getLabel(), core.general.UnitType.BC812));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1212.getLabel(), core.general.UnitType.BC1212));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1412.getLabel(), core.general.UnitType.BC1412));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1612.getLabel(), core.general.UnitType.BC1612));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1612STS.getLabel(), core.general.UnitType.BC1612STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC812W.getLabel(), core.general.UnitType.BC812W));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1212STS.getLabel(), core.general.UnitType.BC1212STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC416.getLabel(), core.general.UnitType.BC416));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC416ATS.getLabel(), core.general.UnitType.BC416ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC516.getLabel(), core.general.UnitType.BC516));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC716.getLabel(), core.general.UnitType.BC716));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC716ATS.getLabel(), core.general.UnitType.BC716ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC916.getLabel(), core.general.UnitType.BC916));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC916ATS.getLabel(), core.general.UnitType.BC916ATS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1416.getLabel(), core.general.UnitType.BC1416));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1416STS.getLabel(), core.general.UnitType.BC1416STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1616.getLabel(), core.general.UnitType.BC1616));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC1616STS.getLabel(), core.general.UnitType.BC1616STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.BC2316STS.getLabel(), core.general.UnitType.BC2316STS));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX50.getLabel(), core.general.UnitType.ROX50));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX60.getLabel(), core.general.UnitType.ROX60));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX70.getLabel(), core.general.UnitType.ROX70));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX100.getLabel(), core.general.UnitType.ROX100));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.ROX110.getLabel(), core.general.UnitType.ROX110));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.GPS10.getLabel(), core.general.UnitType.GPS10));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.RC1411.getLabel(), core.general.UnitType.RC1411));
            V_DATA_PROVIDER_ALL_DEVICES.push(new utils.dataprovider.UnitItemRendererData(core.general.UnitType.PC2814.getLabel(), core.general.UnitType.PC2814));
            return;
        }

        public static function isSupported(arg1:core.general.UnitType):Boolean
        {
            var loc2:*=0;
            var loc1:*=V_DATA_PROVIDER_ALL_DEVICES.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                if (V_DATA_PROVIDER_ALL_DEVICES[loc2].data == arg1) 
                {
                    return true;
                }
                ++loc2;
            }
            return false;
        }

        public static var V_DATA_PROVIDER_ALL_DEVICES:__AS3__.vec.Vector.<utils.dataprovider.UnitItemRendererData>;
    }
}


//  class CommonWeightUnitDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class CommonWeightUnitDataProvider extends Object
    {
        public function CommonWeightUnitDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("UNIT_KG"), "data":"kg"}, {"label":utils.LanguageManager.getString("UNIT_LB"), "data":"lb"}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class CommonWheelSizeSelectionModeDataProvider
package utils.dataprovider 
{
    import __AS3__.vec.*;
    import core.general.*;
    import utils.*;
    
    public class CommonWheelSizeSelectionModeDataProvider extends Object
    {
        public function CommonWheelSizeSelectionModeDataProvider()
        {
            super();
            return;
        }

        public static function init():void
        {
            V_DATA_PROVIDER = __AS3__.vec.Vector.<Object>([{"label":utils.LanguageManager.getString("WHEELSIZE_MANUAL"), "data":core.general.WheelSizeSelectionMode.MANUAL.toString()}, {"label":utils.LanguageManager.getString("WHEELSIZE_TIRE"), "data":core.general.WheelSizeSelectionMode.TIRE.toString()}]);
            return;
        }

        public static var V_DATA_PROVIDER:__AS3__.vec.Vector.<Object>;
    }
}


//  class GraphicsnameConstants
package utils.dataprovider 
{
    public class GraphicsnameConstants extends Object
    {
        public function GraphicsnameConstants()
        {
            super();
            return;
        }

        public static const FavoriteBatteryStatusIcon:String="FavoriteBatteryStatusIcon";

        public static const FavoriteCyclingIcon:String="FavoriteCyclingIcon";

        public static const FavoriteDownhillIcon:String="FavoriteDownhillIcon";

        public static const FavoriteGPSIcon:String="FavoriteGPSIcon";

        public static const FavoriteHeartrateIcon:String="FavoriteHeartrateIcon";

        public static const FavoriteLapIcon:String="FavoriteLapIcon";

        public static const FavoriteNavigationIcon:String="FavoriteNavigationIcon";

        public static const FavoriteNotDisplayIcon:String="FavoriteNotDisplayIcon";

        public static const FavoriteTemperatureIcon:String="FavoriteTemperatureIcon";

        public static const FavoriteTimeIcon:String="FavoriteTimeIcon";

        public static const FavoriteUphillIcon:String="FavoriteUphillIcon";
    }
}


//  class RouteTypeCommon
package utils.dataprovider 
{
    public class RouteTypeCommon extends Object
    {
        public function RouteTypeCommon()
        {
            super();
            return;
        }

        public static const ALL_TRIPS:String="alltrips";

        public static const ONE_WAY_TRIP:String="onewaytrip";

        public static const ROUND_TRIP:String="roundtrip";
    }
}


//  class UnitItemRendererData
package utils.dataprovider 
{
    import core.general.*;
    import core.units.*;
    import utils.*;
    
    public class UnitItemRendererData extends utils.ItemRendererDataObjectBase
    {
        public function UnitItemRendererData(arg1:String="", arg2:Object=null)
        {
            super(arg1, arg2);
            var loc1:*=arg2 as core.general.UnitType;
            usb = !(core.units.UnitFactory.usbSupported().indexOf(loc1) == -1);
            ble = !(core.units.UnitFactory.bleSupported().indexOf(loc1) == -1);
            nfc = !(core.units.UnitFactory.nfcSupported().indexOf(loc1) == -1);
            return;
        }

        public var ble:Boolean=false;

        public var nfc:Boolean=false;

        public var usb:Boolean=false;
    }
}


