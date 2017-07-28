//class Locales
package frontend 
{
    public class Locales extends Object
    {
        public function Locales()
        {
            super();
            return;
        }

        public static function locale():frontend.LocaleManager
        {
            if (!_instance) 
            {
                _instance = new frontend.LocaleManager();
            }
            return _instance;
        }

        public static function getString(arg1:String, arg2:Array=null, arg3:String=null):String
        {
            return locale().getString(DEFAULT_LANGUAGE_BUNDLENAME, arg1, arg2, arg3);
        }

        
        {
            DEFAULT_LANGUAGE_BUNDLENAME = "language";
        }

        public static var DEFAULT_LANGUAGE_BUNDLENAME:String="language";

        internal static var _instance:frontend.LocaleManager;
    }
}


