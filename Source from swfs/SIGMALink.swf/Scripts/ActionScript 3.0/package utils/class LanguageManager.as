//class LanguageManager
package utils 
{
    public class LanguageManager extends Object
    {
        public function LanguageManager()
        {
            super();
            return;
        }

        public static function getString(arg1:String, arg2:Array=null, arg3:String=null):String
        {
            return getStringFunction("language", arg1, arg2, arg3) as String;
        }

        public static const DEFAULT_LANGUAGE_PACK:String="language";

        public static var getStringFunction:Function;
    }
}


