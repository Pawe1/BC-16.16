//class CommonLanguageDataProvider
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


