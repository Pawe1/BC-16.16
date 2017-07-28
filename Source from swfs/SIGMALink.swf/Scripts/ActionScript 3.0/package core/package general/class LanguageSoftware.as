//class LanguageSoftware
package core.general 
{
    import flash.system.*;
    
    public class LanguageSoftware extends Object
    {
        public function LanguageSoftware()
        {
            super();
            return;
        }

        public static function fromSystemLanguage():String
        {
            var loc3:*=0;
            var loc1:*="en_US";
            var loc2:*=SYSTEM_LANGUAGE_CODE.length;
            var loc4:*=flash.system.Capabilities.language;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (SYSTEM_LANGUAGE_CODE[loc3][0] == loc4) 
                {
                    loc1 = SYSTEM_LANGUAGE_CODE[loc3][1];
                    break;
                }
                ++loc3;
            }
            return loc1;
        }

        
        {
            SYSTEM_LANGUAGE_CODE = [["cs", "cs_CZ"], ["de", "de_DE"], ["en", "en_US"], ["es", "es_ES"], ["fr", "fr_FR"], ["it", "it_IT"], ["nl", "nl_NL"], ["pl", "pl_PL"]];
        }

        public static const CS_CZ:String="cs_CZ";

        public static const DE_DE:String="de_DE";

        public static const EN_US:String="en_US";

        public static const ES_ES:String="es_ES";

        public static const FR_FR:String="fr_FR";

        public static const IT_IT:String="it_IT";

        public static const JA_JP:String="ja_JP";

        public static const NL_NL:String="nl_NL";

        public static const PL_PL:String="pl_PL";

        public static const ZH_CN:String="zh_CN";

        internal static var SYSTEM_LANGUAGE_CODE:Array;
    }
}


