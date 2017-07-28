//class CommonFavoritesPC2812DataProvider
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


